%%  感知节点位置生成
%输入参数
%node_number  感知节点的数目
%source_position  辐射源的位置
%Spatial_area  感知节点所处的空间范围
%输出参数
%position   所有感知节点的位置


function [position]=NodePositionGeneration(node_number,source_position, Spatial_area)


position = zeros(node_number,2);
        for i=1:node_number
%             position(i,:)=Spatial_area(1)+(Spatial_area(2)-Spatial_area(1))*rand(1,2);
              position(i,:)= randi(Spatial_area,1,2);
                deltax = position(i,1) - source_position(1);
                deltay = position(i,2) - source_position(2);
              if abs(deltax)<=2e3
                        position(i,1) = position(i,1) + sign(deltax)*2e3;
              end
               if abs(deltay)<=2e3
                        position(i,2) = position(i,2) + sign(deltay)*2e3;
              end
        end


        position(1:5,:) = [-10, 10; 10, -10; -10, -10; 10, 10; 5, 20] * 1e3;
end
