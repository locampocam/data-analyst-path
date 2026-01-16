function findUniqueAndAddToSheet1() {
  var ss = SpreadsheetApp.getActiveSpreadsheet();

  // Obtener las hojas
  var sheet1 = ss.getSheetByName("Sheet1");
  var sheet2 = ss.getSheetByName("Sheet2");

  if (!sheet1 || !sheet2) {
    Logger.log("Una o ambas hojas no existen.");
    return;
  }

  // Obtener los datos completos desde la fila 2 (para evitar encabezados)
  var dataSheet1 = sheet1.getRange(2, 1, sheet1.getLastRow() - 1, sheet1.getLastColumn()).getValues();
  var dataSheet2 = sheet2.getRange(2, 1, sheet2.getLastRow() - 1, sheet2.getLastColumn()).getValues();

  if (dataSheet1.length === 0 || dataSheet2.length === 0) {
    Logger.log("No hay datos suficientes en Sheet1 o Sheet2.");
    return;
  }

  // Extraer solo los job_id (Columna H, índice 7)
  var jobIdsSheet1 = new Set(dataSheet1.map(row => row[7])); // Conjunto para búsqueda rápida
  var jobIdsSheet2 = new Set(dataSheet2.map(row => row[7]));

  // Encontrar las filas únicas de Sheet2 (job_id no presentes en Sheet1)
  var uniqueRowsSheet2 = dataSheet2.filter(row => !jobIdsSheet1.has(row[7]));

  if (uniqueRowsSheet2.length === 0) {
    Logger.log("No se encontraron datos únicos en Sheet2.");
    return;
  }

  // Crear o limpiar la hoja de resultados
  var resultSheet = ss.getSheetByName("Datos Únicos Sheet2") || ss.insertSheet("Datos Únicos Sheet2");
  resultSheet.clear();

  // Encabezados (ajusta si es necesario)
  var headers = [
    "Estado", "Posición", "Fecha de Postulación", "Plataforma", "Empresa", "Rubro",
    "Nombre del Reclutador", "Link Posición", "Link Empresa", "Link Reclutador"
  ];
  resultSheet.appendRow(headers);

  // Escribir datos únicos en "Datos Únicos Sheet2"
  resultSheet.getRange(2, 1, uniqueRowsSheet2.length, uniqueRowsSheet2[0].length).setValues(uniqueRowsSheet2);

  // Agregar los datos únicos también a Sheet1 (base de datos)
  sheet1.getRange(sheet1.getLastRow() + 1, 1, uniqueRowsSheet2.length, uniqueRowsSheet2[0].length).setValues(uniqueRowsSheet2);

  Logger.log("Se han copiado las filas únicas de Sheet2 en 'Datos Únicos Sheet2' y también se han agregado a Sheet1.");
}
