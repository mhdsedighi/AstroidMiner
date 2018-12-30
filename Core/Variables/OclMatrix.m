classdef OclMatrix < OclStructure
  %OCLMATRIX Matrix valued structure for variables
  %
  properties
    msize
  end
  
  methods
    
    function self = OclMatrix(size)
      % OclMatrix(size)
      self.msize = size;
    end
    
    function r = size(self)
      r = self.msize;
    end
    
    function [r,p] = get(self,pos,dim1,dim2)
      % get(pos,dim1)
      % get(pos,dim1,dim2)
      pos = reshape(pos,self.size);
      if nargin == 2
        pos = pos(dim1);
      else
        pos = pos(dim1,dim2);
      end
      r = OclMatrix(pos);
      p = pos;
    end
  end
end

