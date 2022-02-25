import 'dart:ffi';

class VModel
{
  List _atributes;
  String _table;
  String _primaryKey;
  
  VModel
  (
    id,
    this._atributes,
    this._primaryKey,
    this._table,
  );

  setAtribute(String atribute)
  {
    if( !atribute.isEmpty )
    {
      this._atributes.add(atribute);
    }
  }

  setAtributes(List atributes)
  {
    if( !atributes.isEmpty )
    {
      this._atributes = atributes;
    }
  }

  getAtributes()
  {
    return this._atributes;
  }

  setTable(String table)
  {
    if( !table.isEmpty )
    {
      this._table = table;
    }
  }
  
  getTable()
  {
    return this._table;
  }
  
  setPrimaryKey(String primaryKey)
  {
    if( !primaryKey.isEmpty )
    {
      this._primaryKey = primaryKey;
    }
  }

  getPrimaryKey()
  {
    return this._primaryKey;
  }

  store()
  {

  }

  delete()
  {

  }

  getObjects(List filter)
  {

  }

  getObject(id)
  {
    
  }
}