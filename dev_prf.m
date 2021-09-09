function dp=dev_prf(d,E)
%return the value of device profits function for a given device (d) and Energy
%consumption point (E unit: J)

    global device;
    sftthhd=device(d,4); %soft threshold
    hdthhd=device(d,5);   %hard threshold
    dp=0;
    
%     if E <= sftthhd
%         dp=device(d,3);
%     end
%     if E >= hdthhd
%         dp=0;
%     end
%     if E>sftthhd && E<hdthhd
%         dp=device(d,3)-(E-device(d,4))*(device(d,3)-device(d,2))/(device(d,5)-device(d,4));
%     end
    
    if E <= sftthhd
        dp=device(d,3);
    else if E >= hdthhd
            dp=0;
        else
            dp=device(d,3)-(E-device(d,4))*(device(d,3)-device(d,2))/(device(d,5)-device(d,4));
        end
    end
    end

    
    
    
    