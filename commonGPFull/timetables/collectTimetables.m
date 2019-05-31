clear
clusts = {'ProxClustA','ProxClustB','MidProxClustA','MidProxClustB','MidDistClustA','MidDistClustB','DistClustA','DistClustB'};

for i = 1:1:8
    for j = 2.5:2.5:20
        if j == 2.5
            jstr = '2p5';
        elseif j == 7.5
            jstr = '7p5';
        elseif j == 12.5
            jstr = '12p5';
        elseif j == 17.5
            jstr = '17p5';
        else
            jstr = num2str(j);
        end
        eval(['times_' char(clusts(i)) jstr 'Hz = load(''times_' char(clusts(i)) num2str(j) 'Hz.asc'')/5e-5;']);
        
    end
end
