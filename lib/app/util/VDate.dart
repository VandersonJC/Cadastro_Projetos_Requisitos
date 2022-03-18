import 'dart:ffi';

import 'package:intl/intl.dart';

class VDate
{

static String ConvertDateUsInBr(DateTime dt, bool fl_horas)
{
  String dt_convert;

  if( fl_horas )
  {
    dt_convert = DateFormat('dd/MM/yyyy - HH:mm').format(dt);
  }
  else
  {
      dt_convert =DateFormat('dd/MM/yyyy').format(dt);
  }

  return dt_convert;
}
/**
  * convert your  string in  datetime
  */
static DateTime ConvertStringInDatetime(String dt)
{ 
  return DateTime.parse(dt);
}

/**
  * convert your strin in string
  */
static String ConvertDatetimeInString(DateTime dt)
{ 
  return '$dt';
}

}