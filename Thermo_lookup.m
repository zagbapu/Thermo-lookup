
%Importing the required tables into MATLAB

sat = xlsread('Sat.xlsx');
comp = excel_import('Comp.xlsx',18);
SH = excel_import('SH.xls',16);

%Requesting the required pressure and temperature

pressure = input('\n\nWhat is the pressure in MPa? - ');
temp = input('\n\nWhat is the temp in °C? - ');

%Checking the sat. temp at given pressure by interpolation

Sat_temp = interp1(sat(:,1),sat(:,2),pressure);

% If the input temperature is close enough to the saturated
% temperature at the pressure, it is a saturated subustance

if abs(temp-Sat_temp)<=2
    
    %Interpolating the other properties of the state

    Output = interp1(sat(:,1),sat(:,[3,4,5,6,7,9,10,12]),pressure);
    
    %Displaying the output for the saturated liquid
     
    fprintf('\nState          : Saturated \n')
    fprintf('Pressure       : %4.2f MPa \n',pressure)
    fprintf('Temperature    : %4.2f °C \n',temp)
    fprintf('Fluid Volume   : %4.6f m³/kg \n',Output(1))
    fprintf('Gas Volume     : %4.6f m³/kg \n',Output(2))
    fprintf('Fluid Energy   : %4.1f kJ/kg \n',Output(3))
    fprintf('Gas Enery      : %4.2f kJ/kg \n',Output(4))
    fprintf('Fluid Enthalpy : %4.2f kJ/kg \n',Output(5))
    fprintf('Gas Enthalpy   : %4.2f kJ/kg \n',Output(6))
    fprintf('Fluid Entropy  : %4.4f kJ/kg.K \n',Output(7))
    fprintf('Gas Entropy    : %4.4f kJ/kg.K \n',Output(8))

    %If the temperature is less than the sturated temperature at that
    %pressure, it is a compressed liquid
    
elseif temp < Sat_temp
    points = findpoint(comp,pressure,temp);
    Output = multi_int(pressure,temp,points);
   
     %Displaying the output for the compressed liquid
    
    fprintf('\nState       : Compressed Liquid \n')
    fprintf('Pressure    : %4.2f MPa \n',Output(1));
    fprintf('Temperature : %4.2f °C \n',Output(2));
    fprintf('Density     : %4.2f kg/m³ \n',Output(3));
    fprintf('Energy      : %4.2f m³/kg \n',Output(4));
    fprintf('Enthalpy    : %4.2f kJ/kg \n',Output(5));
    fprintf('Entropy     : %4.2f kJ/kg.K \n',Output(6));
   
    %If the temperature is greater than the saturated temperature at that
    %pressure, it is superheated steam
    
    elseif temp > Sat_temp
    points = findpoint(SH,pressure,temp);
    Output = multi_int(pressure,temp,points);
    
    %Displaying the output for the saturated liquid
    
    fprintf('\nState       : Superheated Steam \n')
    fprintf('Pressure    : %4.2f MPa \n',Output(1));
    fprintf('Temperature : %4.2f °C \n',Output(2));
    fprintf('Density     : %4.6f kg/m³ \n',Output(3));
    fprintf('Energy      : %4.2f m³/kg \n',Output(4));
    fprintf('Enthalpy    : %4.2f kJ/kg \n',Output(5));
    fprintf('Entropy     : %4.4f kJ/kg.K \n',Output(6));   
    
end
