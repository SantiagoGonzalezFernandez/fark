
bool isNumeric(String value){
  if(value.isEmpty) return false;

  final numero = num.tryParse(value);

  return(numero == null) ? false : true;
}