clusts = {'ProxClustA','ProxClustB','MidProxClustA','MidProxClustB','MidDistClustA','MidDistClustB','DistClustA','DistClustB'};
eventRates = [2.5 5 7.5 10 12.5 15 17.5 20]; %Hz
dt = 5*10^-5;%seconds
totalTime = 100; %seconds


for i = 1:1:length(clusts)
    for j = 1:1:length(eventRates)
        clust = char(clusts(i));
        eventRate = eventRates(j);
        filename = ['times_' clust num2str(eventRate) 'Hz.asc'];
        fid = fopen(filename,'w');

        eventTimes = zeros(1);
        eventCounter = 0;
        for k = 1:1:totalTime / dt
            if rand(1) / dt > 1 / dt - eventRate
                eventCounter = eventCounter + 1;
                eventTimes(eventCounter) = round(k * dt * 20000) / 20000;
                fprintf(fid, [num2str(eventTimes(eventCounter)) '\n']);
            end
        end
        fclose(fid);
        eventTimes = transpose(eventTimes);
    end
end