function [model] = getReliabilityCapacitor(capacitor_struct, K_c, K_r)
    Group = capacitor_struct.Group;
    L_b = capacitor_struct.L_b;
    K_pr = capacitor_struct.K_pr;
    K_e = capacitor_struct.K_e;

    switch Group
    case "Group_1"
        % disp(Group)
        model = 1e-6*(L_b * K_r * K_c * K_pr * K_e);
    case "Group_2"
        model = 1e-6*(L_b * K_r * K_pr * K_e);
        % disp(Group)
    case "Group_3"
        model = 1e-6*(L_b * K_r * K_c * K_pr * K_e);
        % disp(Group)
    case "Group_5"
        model = 1e-6*(L_b * K_r * K_c * K_pr * K_e);
        % disp(Group)
    case "Group_6"
        % model = 1e-6*(L_b * K_r * K_pc * K_pr * K_e);
        model = inf;
        % disp(Group)
    case "Group_7"
        model = 1e-6*(L_b * K_r * K_c * K_pr * K_e);
        % disp(Group)
    case "Group_8"
        % model = v(L_b * K_t * K_c * K_pr * K_e);
        model = inf;
        % disp(Group)
    case "Group_9"
        model = 1e-6*(L_b * K_r * K_c * K_pr * K_e);
        % disp(Group)
    case "Group_10"
        model = 1e-6*(L_b * K_r * K_pr * K_e);
        % disp(Group)
    case "Group_12"
        model = 1e-6*(L_b * K_r * K_pr * K_e);
        % disp(Group)
        otherwise
            model = inf;

end

end
