function dpd=DevProDertv(d,E)
%return the value of device profits function for a given device (d) and Energy
%consumption point (E unit: J)

    global device;
    sftthhd=device(d,4); %soft threshold
    hdthhd=device(d,5);   %hard threshold
    dpd=0;

    if E <= sftthhd
        dpd=0;
    else if E >= hdthhd
            dpd=0;
        else
            dpd=(device(d,2)-device(d,3))/(device(d,5)-device(d,4));
        end
    end
end