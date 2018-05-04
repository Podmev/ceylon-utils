import ceylon.ast.core {
    ModuleDescriptor,
    FullPackageName,
    LIdentifier,
    AnyCompilationUnit,
    ModuleCompilationUnit,
    PackageDescriptor,
    PackageCompilationUnit
}
shared ModuleDescriptor[] getModuleDescriptors(AnyCompilationUnit compilationUnit) =>
        if(is ModuleCompilationUnit compilationUnit) then [compilationUnit.moduleDescriptor] else [];

shared PackageDescriptor[] getPackageDescriptors(AnyCompilationUnit compilationUnit) =>
        if(is PackageCompilationUnit compilationUnit) then [compilationUnit.packageDescriptor] else [];

"Получение имени по определению модуля"
shared String getModuleDescriptorName(ModuleDescriptor moduleDescriptor){
    FullPackageName fullPackageName = moduleDescriptor.name;
    [LIdentifier+] identifiers = fullPackageName.components;
    [String+] identifierNames = identifiers*.text; //TODO посмотреть это ли надо
    return ".".join(identifierNames);
}