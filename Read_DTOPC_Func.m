function x = Read_DTOPC_Func(y)
%Variables
persistent init_Server;
persistent init_Nodes;
persistent ua_Client;


%Nodes
    %Writeable Variables
    %persistent xt;
    %persistent yl;
    %persistent vyt;		
  
    %Readable Variables
    persistent M1_Bas;
    persistent M1_Haut;
    persistent M2;
    persistent M3;
    persistent M4;
    persistent M5;
    persistent M6;


%initializate variables
if(isempty(init_Server))
    init_Server = 0;
    init_Nodes = 0;
end

if init_Server == 0
    init_Server = 1;
    server = opcuaserverinfo('DT-OPCUA');
    ua_Client = opcua(server);
    connect(ua_Client);
end

if ua_Client.isConnected && init_Nodes == 0
    init_Nodes =1;
    DB_Node = findNodeByName(ua_Client.Namespace,'PLCnext','-once');

    %READ
    M1_Bas = findNodeByName(DB_Node,'M1_Bas','-once');
    M1_Haut = findNodeByName(DB_Node,'M1_Haut','-once');
    M2 = findNodeByName(DB_Node,'M2','-once');
    M3 = findNodeByName(DB_Node,'M3','-once');
    M4 = findNodeByName(DB_Node,'M4','-once');
    M5 = findNodeByName(DB_Node,'M5','-once');
    M6 = findNodeByName(DB_Node,'M6','-once');
    

end
if ua_Client.isConnected == 1 && init_Nodes==1
    
    [M1Bas_, ~,~] = readValue(ua_Client,M1_Bas);
    [M1_Haut_, ~,~] = readValue(ua_Client,M1_Haut);
    [M2_, ~,~] = readValue(ua_Client,M2);
    [M3_, ~,~] = readValue(ua_Client,M3);
    [M4_, ~,~] = readValue(ua_Client,M4);
    [M5_, ~,~] = readValue(ua_Client,M5);
    [M6_, ~,~] = readValue(ua_Client,M6);

   x=double([M3_,M2_,M1Bas_,M1_Haut_,M4_,M5_,M6_]);

end

if y>1000
    M4 = 0;
end

end


