#!/bin/gawk -f

function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s; }
function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s; }
function trim(s) { return rtrim(ltrim(s)); }


BEGIN{
	IGNORECASE=1;
	
	arrFiles[0]="index.html";
	
	fileNameAnt="";
	outFileName="";
	swInfoFilename=0; # 0--> No filename info proccesed. 1--> Filename info proccesed.
	
	nMembers=0;	#Number of members procesed.
	
	
	strMEMBERTYPE="";
	strACCESS="";
	strCLASSNAME="";
	strCODECOMMENT="";
	strDATATYPE="";
	strDECL="";
	strDEFVAL="";
	strEXAMPLE="";
	strEXPLANATION="";
	strMETHODTYPE="";
	strNAME="";
	strPARAM="";
	strRETURNTYPE="";
	strVARTYPE="";
	strVERSION="";
	
}
	
FILENAME !="" && FILENAME !=fileNameAnt{
	arrFiles[length(arrFiles)]=trim(FILENAME);
	outFileName=arrFiles[length(arrFiles)-1];
	
	
	
	#****TODO: Build FILENAME.html
	
	
	

	fileNameAnt=FILENAME;
}
/''@MEMBERTYPE:/{	#First Meta of each member ....
	
	
	
	
	
	
	if(nMembers>0)	##If There is DATA .... 
	{
		
		#TODO: Print The metas ...
	
		#**** Initialize variables
		strMEMBERTYPE="";
		strACCESS="";
		strCLASSNAME="";
		strCODECOMMENT="";
		strDATATYPE="";
		strDECL="";
		strDEFVAL="";
		strEXAMPLE="";
		strEXPLANATION="";
		strMETHODTYPE="";
		strNAME="";
		strPARAM="";
		strRETURNTYPE="";
		strVARTYPE="";
		strVERSION="";
	}

	next;	#Next File Record
}

/^[ \t]*''(@[A-Z]+):/{	#Each Meta ....
	strDirectiva="";
	if(match($0, /''(@[A-Z]+):/)>0)
		strDirectiva=trim(substr($0, RSTART+2, RLENGTH-3));
		
		
	
	print "=====>" strDirectiva;
}

END{
	#***TODO: Build index in index.html.
	#asort(arrFiles)	# Sorts the index
}