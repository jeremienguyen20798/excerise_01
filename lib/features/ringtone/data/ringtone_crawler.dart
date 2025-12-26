import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

/// Fetches an .mp3 URL from a ringtone detail page.
///
/// Strategy (in order):
/// 1. Look for an <audio> tag and its <source> child.
/// 2. Look for Open Graph meta tags like og:audio or og:audio:url.
/// 3. Look for anchor tags whose href contains ".mp3".
/// 4. Fallback: regex search in the raw HTML for any https?://... .mp3 URL.
Future<String?> fetchMp3Link(String detailPageUrl) async {
  final uri = Uri.parse(detailPageUrl);
  final resp = await http.get(uri, headers: {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
  });

  if (resp.statusCode != 200) return null;

  final doc = parse(resp.body);

  // 1) <audio> or <audio><source src="...">
  final audio = doc.querySelector('audio');
  if (audio != null) {
    final srcAttr = audio.attributes['src'];
    if (srcAttr != null && srcAttr.contains('.mp3')) {
      return _resolveUrl(uri, srcAttr);
    }
    final source = audio.querySelector('source');
    final sourceSrc = source?.attributes['src'];
    if (sourceSrc != null && sourceSrc.contains('.mp3')) {
      return _resolveUrl(uri, sourceSrc);
    }
  }

  // 2) meta og:audio or og:audio:url
  final metaOg = doc.querySelector('meta[property="og:audio"]') ??
      doc.querySelector('meta[property="og:audio:url"]') ??
      doc.querySelector('meta[name="twitter:audio:src"]');
  if (metaOg != null) {
    final content = metaOg.attributes['content'];
    if (content != null && content.contains('.mp3')) return _resolveUrl(uri, content);
  }

  // 3) links with .mp3
  for (final a in doc.querySelectorAll('a[href]')) {
    final href = a.attributes['href'] ?? '';
    if (href.contains('.mp3')) return _resolveUrl(uri, href);
  }
  return null;
}

String _resolveUrl(Uri base, String href) {
  try {
    final parsed = Uri.parse(href);
    if (parsed.hasScheme) return parsed.toString();
  } catch (_) {}
  return base.resolve(href).toString();
}

// Usage example:
// final mp3 = await fetchMp3Link('https://example.com/ringtone/123');
// if (mp3 != null) print('Found mp3: $mp3');
