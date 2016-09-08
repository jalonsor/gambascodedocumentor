#!/bin/gawk -f

function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s; }
function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s; }
function trim(s) { return rtrim(ltrim(s)); }

BEGIN{
	IGNORECASE=1;
	
	strClassModuleINFO="";
	
	strPowerOf=					"''******************************************************"
	strPowerOf=strPowerOf 	"''Code documented by: gambasCodeDocumentor V. 1.0.1.\n"
	strPowerOf=strPowerOf 	"''https://github.com/jalonsor/gambascodedocumentor\n";
	strPowerOf=strPowerOf 	"''******************************************************"
	
	swInfoFilename=0; # 0--> No filename info proccesed. 1--> Filename info proccesed.
	swInfoFilePrinted=0;# 0--> Not Printed. 1--> Printed.
}

FILENAME !="" && swInfoFilename==0{
	# *** Filename processed
	#print "Filename processed =====> " FILENAME;	
	
	strClassModuleINFO="";
	strMemberType="";
	
	if(match(FILENAME, /\.class/)>0)
	{
		strMemberType="Class";
	}
	else
	{
		strMemberType="Module";
	}
	
	strClassModuleINFO=strClassModuleINFO "\n\n''*************************************************************************\n";
	strClassModuleINFO=strClassModuleINFO "''@MEMBERTYPE:" strMemberType "\n";
	strClassModuleINFO=strClassModuleINFO "''@CLASSNAME:" FILENAME "\n";
	strClassModuleINFO=strClassModuleINFO "''@VERSION:XX.XX.XX[A|B]\n";
	strClassModuleINFO=strClassModuleINFO "''@EXPLANATION:\n";
	strClassModuleINFO=strClassModuleINFO "''@EXPLANATION:\n";
	strClassModuleINFO=strClassModuleINFO "''@EXPLANATION:\n";
	strClassModuleINFO=strClassModuleINFO "''@EXPLANATION:\n";
	strClassModuleINFO=strClassModuleINFO "''@EXAMPLE:\n";
	strClassModuleINFO=strClassModuleINFO "''@EXAMPLE:\n";
	strClassModuleINFO=strClassModuleINFO "''@EXAMPLE:\n";
	strClassModuleINFO=strClassModuleINFO "''@EXAMPLE:\n";
	strClassModuleINFO=strClassModuleINFO "''*************************************************************************\n\n\n";
	
	swInfoFilename=1;	#Filename info proccesed.
	strMemberType="";
}

/^[ \t]*(CLASS |CREATE STATIC *|CREATE PRIVATE *|EXPORT *|FAST *|INHERITS |USE )/ && swInfoFilename==1 && swInfoFilePrinted==0{ 
	#Class or Module Options .... Fast, Inherits, Class, Static, Etc ... (http://gambaswiki.org/wiki/cat/object)
	
	
}

# *** First Code line after, inherits, Create, etc ...
/^[ \t]*(property |Private |Public |static |function |sub |procedure )/ && swInfoFilename==1 && swInfoFilePrinted==0{
	print strClassModuleINFO;
	swInfoFilePrinted=1;
}

# *** Public or Private Constants
/^[ \t]*(public|private) +const /{
	strDec="";
	strCodeComment="";
	strVarType="";
	strDataType="";
	strDefVal="";
	strAccess="";
	strName="";
	
	nSplit=split($0, arr, /'+/);
	strDec=trim(arr[1]);
	strCodeComment=trim(arr[2]);
	nSplit=split(strDec, arr, /([Aa][Ss]|=)/);
	strDataType=trim(arr[2]);
	strDefVal=trim(arr[nSplit]);
	strAccess=$1;
	#strVarType=$2;
	strName=$3;
	
	strDoc="";
	strDoc=strDoc "\n\n''@MEMBERTYPE:Constant\n";	#Constant, Property, Variable, Method ....
	strDoc=strDoc "''@DECL:" strDec "\n";
	strDoc=strDoc "''@NAME:" strName "\n";
	strDoc=strDoc "''@ACCESS:" strAccess "\n";			#Private, Public
	strDoc=strDoc "''@VARTYPE:" strVarType "\n";		#Static ...
	strDoc=strDoc "''@DATATYPE:" strDataType "\n";	#Byte, Integer, Object ...
	strDoc=strDoc "''@DEFVAL:" strDefVal "\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@CODECOMMENT:" strCodeComment "\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:";
	
	print strDoc "\n" $0;
	strDoc="";
	next;	#Next File Record	
}

# *** Properties ReadOnly
/^[ \t]*(static)? *property read /{
	strDec="";
	strCodeComment="";
	strVarType="";
	strDataType="";
	strDefVal="";
	strAccess="";
	strName="";
		
	nSplit=split($0, arr, /'+/);
	strDec=trim(arr[1]);
	strCodeComment=trim(arr[2]);
	nSplit=split(strDec, arr, /([Aa][Ss]|=)/);
	strDataType=trim(arr[2]);
	strDefVal="";
	
	if(match($1, /static/)>0) strVarType=trim($1);
	strAccess="Public";
	if(length(strVarType)==0)
		strName=$3;
	else
		strName=$4;
	
	strDoc="";
	strDoc=strDoc "\n\n''@MEMBERTYPE:Property ReadOnly\n";	#Constant, Property, Variable, Method ....
	strDoc=strDoc "''@DECL:" strDec "\n";
	strDoc=strDoc "''@NAME:" strName "\n";
	strDoc=strDoc "''@ACCESS:" strAccess "\n";			#Private, Public
	strDoc=strDoc "''@VARTYPE:" strVarType "\n";		#Static ...
	strDoc=strDoc "''@DATATYPE:" strDataType "\n";	#Byte, Integer, Object ...
	strDoc=strDoc "''@DEFVAL:" strDefVal "\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@CODECOMMENT:" strCodeComment "\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:";
	
	print strDoc "\n" $0;
	strDoc="";
	next;	#Next File Record
}

# *** Properties ReadWrite
/^[ \t]*(static)? *property /{
	strDec="";
	strCodeComment="";
	strVarType="";
	strDataType="";
	strDefVal="";
	strAccess="";
	strName="";
		
	nSplit=split($0, arr, /'+/);
	strDec=trim(arr[1]);
	strCodeComment=trim(arr[2]);
	nSplit=split(strDec, arr, /([Aa][Ss]|=)/);
	strDataType=trim(arr[2]);
	strDefVal="";
	
	if(match($1, /static/)>0) strVarType=trim($1);
	strAccess="Public";
	if(length(strVarType)==0)
		strName=$2;
	else
		strName=$3;
	
	strDoc="";
	strDoc=strDoc "\n\n''@MEMBERTYPE:Property ReadWrite\n";	#Constant, Property, Variable, Method ....
	strDoc=strDoc "''@DECL:" strDec "\n";
	strDoc=strDoc "''@NAME:" strName "\n";
	strDoc=strDoc "''@ACCESS:" strAccess "\n";			#Private, Public
	strDoc=strDoc "''@VARTYPE:" strVarType "\n";		#Static ...
	strDoc=strDoc "''@DATATYPE:" strDataType "\n";	#Byte, Integer, Object ...
	strDoc=strDoc "''@DEFVAL:" strDefVal "\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@CODECOMMENT:" strCodeComment "\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:";
	
	print strDoc "\n" $0;
	strDoc="";
	next;	#Next File Record
}

# *** Public or Private Variable
/^[ \t]*(static)? *(public|private) / && !/(function|sub|procedure)/{
	strDec="";
	strCodeComment="";
	strVarType="";
	strDataType="";
	strDefVal="";
	strAccess="";
	strName="";
		
	nSplit=split($0, arr, /'+/);
	strDec=trim(arr[1]);
	strCodeComment=trim(arr[2]);
	nSplit=split(strDec, arr, /([Aa][Ss]|=)/);
	strDataType=trim(arr[2]);
	strDefVal=trim(arr[nSplit]);
	
	if(match($1, /static/)>0) strVarType=trim($1);
	if(length(strVarType)==0)
	{
		strAccess=$1;
		strName=$2;
	}
	else
	{
		strAccess=$2;
		strName=$3;
	}
		
	strDoc="";
	strDoc=strDoc "\n\n''@MEMBERTYPE:Variable\n";	#Constant, Property, Variable, Method ....
	strDoc=strDoc "''@DECL:" strDec "\n";
	strDoc=strDoc "''@NAME:" strName "\n";
	strDoc=strDoc "''@ACCESS:" strAccess "\n";			#Private, Public
	strDoc=strDoc "''@VARTYPE:" strVarType "\n";		#Static ...
	strDoc=strDoc "''@DATATYPE:" strDataType "\n";	#Byte, Integer, Object ...
	strDoc=strDoc "''@DEFVAL:" strDefVal "\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@CODECOMMENT:" strCodeComment "\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:";
	
	print strDoc "\n" $0;
	strDoc="";
	next;	#Next File Record
}

# *** Public or Private Methods
/^[ \t]*(static)? *(public|private) +(function|sub|procedure) /{
	#Static Public Function utilSplit(str As String, strSep As String, Optional notEnclosedIn As String[] = Null) As String[] ''Return Value: 	An Element object, which represents the created Element node
	
	strDec="";
	strCodeComment="";
	strVarType="";
	strDataType="";
	strDefVal="";
	strAccess="";
	strName="";
	strParams="";
	strAuxParams="";
	arrAuxParams["count"]="";
	
	nSplit=split($0, arr, /'+/);
	strDec=trim(arr[1]);
	strCodeComment=trim(arr[2]);
	if(match(strDec, /\(.*\)/)>0)
	{
		strAuxParams=trim(substr(strDec, RSTART+1, RLENGTH-2));
		if(strAuxParams=="...")
		{
			strParams="''@PARAM:Variable Number of Parameters.\n";
		}
		else
		{
			nSplitParams=split(strAuxParams, arrAuxParams, /, */);
			if(nSplitParams>0)
			{
				for(i=1;i<=nSplitParams;i++)
				{
					strParams= strParams "''@PARAM:" arrAuxParams[i] "\n";
				}
			}
			else
			{
				strParams="''@PARAM:No Parameters.\n";
			}
		}
	}
	

	nSplit=split(strDec, arr, /\) *[Aa][Ss]/);
	if(nSplit>1)
		strDataType=trim(arr[2]);		#ReturnType.
	else
		strDataType="No return value.";
		
	if(match($1, /static/)>0) strVarType=trim($1);
	if(length(strVarType)==0)
	{
		strAccess=$1;
		strName=$3;
	}
	else
	{
		strVarType=$1
		strAccess=$2;
		strName=$4;
	}
	gsub(/\(.*/, "", strName);	#Clean Method Name.
	
	strDoc="";
	strDoc=strDoc "\n\n''@MEMBERTYPE:Method\n";					#Constant, Property, Variable, Method ....
	strDoc=strDoc "''@DECL:" strDec "\n";
	strDoc=strDoc "''@NAME:" strName "\n";
	strDoc=strDoc "''@ACCESS:" strAccess "\n";				#Private, Public
	strDoc=strDoc "''@METHODTYPE:" strVarType "\n";		#Static ...
	strDoc=strDoc "''@RETURNTYPE:" strDataType "\n";	#Byte, Integer, Object ...
#	strDoc=strDoc "''@PARAM:" strParams "\n";
	strDoc=strDoc strParams;
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@EXPLANATION:\n";
	strDoc=strDoc "''@CODECOMMENT:" strCodeComment "\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:\n";
	strDoc=strDoc "''@EXAMPLE:";
	
	print strDoc "\n" $0;
	strDoc="";
	next;	#Next File Record
}
{
	print $0;
}
END{
	print "\n\n\n" strPowerOf "\n";
}