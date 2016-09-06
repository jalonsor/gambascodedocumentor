#!/bin/gawk -f

function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s; }
function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s; }
function trim(s) { return rtrim(ltrim(s)); }


BEGIN{
	IGNORECASE=1;
	
	arrFiles[0]="index.html";
	
	
	
	fileNameAnt="";
	swInfoFilename=0; # 0--> No filename info proccesed. 1--> Filename info proccesed.
}

#~ @CLASSNAME:
#~ @NAME:" FILENAME "\n";
#~ @MEMBERTYPE" strMemberType "\n";
#~ @VERSION:XX.XX.XX[A|B]\n";
#~ @EXPLANATION:\n";
#~ @EXPLANATION:\n";
#~ @EXPLANATION:\n";
#~ @EXPLANATION:\n";
#~ @EXAMPLE:\n";
#~ @EXAMPLE:\n";
#~ @EXAMPLE:\n";
#~ @EXAMPLE:\n";

#~ @DECL:" strDec "\n";
#~ @NAME:" strName "\n";
#~ @MEMBERTYPE:Constant\n";	#Constant, Property, Variable, Method ....
#~ @ACCESS:" strAccess "\n";			#Private, Public
#~ @VARTYPE:" strVarType "\n";		#Static ...
#~ @DATATYPE:" strDataType "\n";	#Byte, Integer, Object ...
#~ @DEFVAL:" strDefVal "\n";
#~ @EXPLANATION:\n";
#~ @EXPLANATION:\n";
#~ @EXPLANATION:\n";
#~ @EXPLANATION:\n";
#~ @CODECOMMENT:" strCodeComment "\n";
#~ @EXAMPLE:\n";
#~ @EXAMPLE:\n";
#~ @EXAMPLE:\n";
#~ @EXAMPLE:";

#~ @METHODTYPE:" strVarType "\n";		#Static ...
#~ @RETURNTYPE:" strDataType "\n";	#Byte, Integer, Object ...

FILENAME !="" && FILENAME !=fileNameAnt{
	arrFiles[length(arrFiles)]=trim(FILENAME);
	
	fileNameAnt=FILENAME;
}

/^[ \t]*''(@[A-Z]+):/{
	strDirectiva="";
	
	if(match($0, /''(@[A-Z]+):/)>0)
		strDirectiva=trim(substr($0, RSTART+2, RLENGTH-3));
	
	print "=====>" strDirectiva;
}

END{
	
}