
// http://cfile25.uf.tistory.com/image/995E50425C2E0278316120
// -> https://t1.daumcdn.net/cfile/tistory/995E50425C2E027831
String convertAttachmentUrl(String content) {
  String converted;
  var exp = new RegExp(r'http://cfile\d*\.uf\.tistory\.com\/image\/(\w*)');
  converted = content.replaceAllMapped(exp, (Match m) {
    return 'https://t1.daumcdn.net/cfile/tistory/${m[1].substring(0, m[1].length - 4)}';
  });

  return converted;
}

String coverMobileHtml(String content) {
  return '''
  <!doctype html>
  <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width">
	    <meta name="format-detection" content="telephone=no">
      <style>
        body { margin:0; padding: 15px 10px; word-wrap:break-word; color:#333 }
        p {font-size:16px;line-height:28px; margin:0 auto 28px}
        a {color:#3db39e}
        h1 { font-size:2em; line-height:1.1em; margin:2em auto 1em }
        h2 { font-size:1.5em; line-height:1.1em; margin:2em auto 1em }
        h3 { font-size:1.2em; line-height:1.1em; margin:2em auto 1em }
        h4,
        h5,
        h6 { font-size:1em; line-height:1.1em; margin:2em auto 1em }
        ul, ol { margin: 0 auto 32px; padding: 0 0 0 10px; }
        ul li, ol li { margin-left:24px; margin-bottom:10px; }
        ul li { list-style:disc }
        ol li { list-style:decimal }
        blockquote { padding: 10px 20px; margin: 0 auto 28px; border-left:5px solid #eee }
        blockquote,
        blockquote p { font-size:18px; line-height:30px }
        blockquote ol:last-child,
        blockquote ul:last-child,
        blockquote p:last-child { margin-bottom:0 }
        code { font-family: Menlo,Consolas,Monaco,monospace; }
        p code { padding:2px 5px; border-radius:3px; background:#efefef; color:#333; margin:0 2px; border:1px solid #e0e0e0 }
        pre { font-size:15px; padding:15px; border-radius:3px; margin-bottom:10px; font-family: Menlo,Consolas,Monaco,monospace; border:1px solid #ddd }
        iframe { max-width:100%; display:block; margin:0 auto 20px }
        figure { margin:0 }
        img { max-width:100%; height:auto }
        .imageblock {width:auto !important; height:auto !important}
        .imageblock img { max-width:100%; height:auto }
        .imageblock .cap1 { font-size:0.8em }
        hr { margin: 3em 5em 3em; border: 0; border-bottom: 1px solid #ccc; }
      </style>
    </head>
    <body>
    ${content} 
    </body>
  </html>
  ''';
}
