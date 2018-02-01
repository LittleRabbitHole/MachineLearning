function [ norm_attr ] = normalize( attr )
%this function take the features and normalize it
m = mean(attr);
v = std(attr);
norm_attr = (attr - m)/v;
end

