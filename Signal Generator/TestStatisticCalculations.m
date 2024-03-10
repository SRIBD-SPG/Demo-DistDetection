%Test_statistic_calculations
function   [Test_statistic]=TestStatisticCalculations(all_node_data,Para_Stru)
     
%         S=1/Para_Stru.LenData*all_node_data*all_node_data';
        S=1/size(all_node_data,2)*all_node_data*all_node_data';
        Test_statistic=[];
%         S0=1/Para_Stru.LenData*noise*noise';
% set params
        r = 1;
        [H, Sgm,~] = FAD(S, r, Para_Stru.max_iter, Para_Stru.ptol, Para_Stru.ftol);
        H1_M=H*H'+Sgm;
        H0_N=diag(diag(S));
       Test_statistic =[Test_statistic,real((trace(H0_N\S)-trace(H1_M\S)+log(det(H0_N))-log(det(H1_M))))];
end
