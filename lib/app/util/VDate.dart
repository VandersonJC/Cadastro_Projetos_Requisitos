import 'dart:ffi';

import 'package:intl/intl.dart';

class VDate
{

static DateTime ConvertDateBrInUs(DateTime dt, Bool fl_horas)
{
  DateTime dt_convert;

  if( fl_horas == true )
  {
    dt_convert = DateTime.parse(DateFormat('dd/MM/yyyy - HH:mm').format(dt));
  }
  else
  {
      dt_convert = DateTime.parse(DateFormat('dd/MM/yyyy').format(dt));
  }

  return dt_convert;
}
/**
  * convert your datetime in string
  */
static DateTime ConvertStringInDatetime(String dt)
{ 
  return DateTime.parse(dt);
}

}