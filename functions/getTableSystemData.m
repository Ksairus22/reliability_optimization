function [DataSystem] = getTableSystemData(FilenameSystem)
    Data_Capacitor = getTableCapacitorData(FilenameSystem.Capacitors);
    Data_Diod = getTableDiodData(FilenameSystem.Diods);
    Data_Resistor = getTableResistorData(FilenameSystem.Resistors);
    Data_Transistor = getTableTransistorData(FilenameSystem.Transistors);
    
    DataSystem.Capacitor = Data_Capacitor;
    DataSystem.Diod = Data_Diod;
    DataSystem.Resistor = Data_Resistor;
    DataSystem.Transistor = Data_Transistor;
end