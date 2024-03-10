%% 由辐射源位置以及感知节点位置 计算传输延迟以及各感知节点的接收信噪比
%输入参数
% standard_snr  number(-12~-4)参考信噪比（假设距离辐射源5km处的信噪比）
% source_position  矢量（二维空间中辐射源的坐标 1*2）辐射源位置
% all_node_position  数组（二维空间中感知节点的坐标 node_number*2）感知节点位置
%输出参数
%tau 矢量（长度为感知节点个数） 由辐射源位置到各感知节点的传输延迟
%snr 矢量（长度为感知节点个数） 感知节点处的接收信噪比
function [tau,snr]=delayAndSNR(standard_snr,source_position,all_node_position)     
     c=physconst('lightspeed');
     Node_num=size(all_node_position,1);
     tau=[];
     distance=[];
     for i=1:Node_num
         tau=[tau,sqrt(sum((all_node_position(i,:)-source_position).^2))/c];
         distance=[distance,sum((all_node_position(i,:)-source_position).^2)];
     end
     snr=standard_snr.*ones(1,size(all_node_position,1))+10*log10(5000^2./distance);
end
