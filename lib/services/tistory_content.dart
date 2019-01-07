
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