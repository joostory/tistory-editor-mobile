
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
        a {color:#3db39e}
        blockquote { padding: 10px 20px; margin: 0 auto 28px; border-left:5px solid #eee }
        iframe { max-width:100%; }
      </style>
	    <link rel="stylesheet" type="text/css" href="https://t1.daumcdn.net/tistory_admin/assets/blog/0ccc8ebc82d8ddff2b5d35df8bbed2d6312aba8f/blogs/style/content/font.css?_version_=0ccc8ebc82d8ddff2b5d35df8bbed2d6312aba8f" />
	    <link rel="stylesheet" type="text/css" href="https://t1.daumcdn.net/tistory_admin/assets/blog/0ccc8ebc82d8ddff2b5d35df8bbed2d6312aba8f/blogs/style/content/content.css?_version_=0ccc8ebc82d8ddff2b5d35df8bbed2d6312aba8f" />
    </head>
    <body>
    ${content} 
    </body>
  </html>
  ''';
}
