function [outputArg1,outputArg2] = makeSystem(inputArg1,inputArg2)
%MAKESYSTEM ���̊֐��̊T�v�������ɋL�q
%   �ڍא����������ɋL�q
outputArg1 = inputArg1;
outputArg2 = inputArg2;
open_system('vdp');
new_system('new_model_with_vdp')
open_system('new_model_with_vdp');
add_block('built-in/Subsystem', 'new_model_with_vdp/vdp_subsystem')
Simulink.BlockDiagram.copyContentsToSubsystem...
('vdp', 'new_model_with_vdp/vdp_subsystem')
end

