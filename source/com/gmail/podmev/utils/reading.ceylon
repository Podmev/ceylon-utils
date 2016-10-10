void reading() {
}

shared class StructuredRichWorkbook1<out First, out Rest=[]>(first, rest) {
	shared
	First first;
	
	shared
	Rest rest;
}
shared class ExcelClaim(){}
shared class ExcelDepot(){}
shared class ExcelVehicle(){}

shared class StructuredRichWorkbookAD(
	shared RowStructuredSheet<ExcelClaim> claimSheet,
	shared RowStructuredSheet<ExcelDepot> depotSheet,
	shared RowStructuredSheet<ExcelVehicle> vehicleSheet
)extends RichWorkBook({claimSheet,depotSheet,vehicleSheet}) {
	
}

shared class RowStructuredSheet<T>(String name, headers, rowStructures) 
		extends RichSheet(name,expand((headers.chain(rowStructures))*.richCells)){	
	shared [RichRow+] headers;
	shared [RowStructure<T>+] rowStructures;	
	shared {RichRow*} richRows => headers.chain(rowStructures);	
	shared RichSheet richSheet => RichSheet(name, expand(richRows*.richCells));
}
shared class RowStructure<T>(shared T structure, Integer rowNumber, [RichCell+] richCells) extends RichRow(rowNumber, richCells) {}
shared class RichRow(shared Integer rowNumber, shared [RichCell+] richCells) {}
shared class RichCell(shared Anything val, shared Integer row, shared Integer column, shared Boolean isHeader = false, shared {String*} errors = {}) {}
shared class RichSheet(shared String name, shared {RichCell*} richCells) {}
shared class RichWorkBook(shared {RichSheet*} richSheets) {}
