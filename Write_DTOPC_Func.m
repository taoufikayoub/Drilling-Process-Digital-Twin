function x = Write_DTOPC_Func(y)

%Variables
persistent init_Server;
persistent init_Nodes;
persistent ua_Client;


%Nodes
    %Writeable Variables
    persistent B1;
    persistent B2;
    persistent B3;	
    persistent B4;
    persistent PART_Av;
    persistent B11;
    persistent B12;


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

    %WRITE
    B1 = findNodeByName(DB_Node,'B1','-once');
    B2 = findNodeByName(DB_Node,'B2','-once');
    B3 = findNodeByName(DB_Node,'B3','-once');
    B4 = findNodeByName(DB_Node,'B4','-once');
    B11 = findNodeByName(DB_Node,'B11','-once');
    B12 = findNodeByName(DB_Node,'B12','-once');
    PART_Av = findNodeByName(DB_Node,'PART_Av','-once');
    

end
if ua_Client.isConnected == 1 && init_Nodes==1
    
    writeValue(ua_Client,B1,y(3));
    writeValue(ua_Client,B2,y(2));
    writeValue(ua_Client,B3,y(6));
    writeValue(ua_Client,B4,y(7));
    writeValue(ua_Client,B11,y(4));
    writeValue(ua_Client,B12,y(5));
    writeValue(ua_Client,PART_Av,y(1));

   x=1;

end


end


