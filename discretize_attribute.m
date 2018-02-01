function [attr_binCounts, attr_binID] = discretize_attribute( attr, nbins )
%the function discretize contineous var into 10 bins

%this is to separate the range into equal 10 range and return the bin edges
binEdges = linspace(min(attr),max(attr),nbins+1);

%adjust the last bin edge to infinity
ad_binEdges = [binEdges(1:end-1) Inf];

%assign the bin index
[attr_binCounts,attr_binID] = histc(attr, ad_binEdges);
end

