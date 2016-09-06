# gambascodedocumentor
Automated Code Documenter for Gambas Language. Easy and Fast.

Testing Version. Try it with caution.

#gambasCodeDocumentor.awk
	Script that comments the code to generate documentation from these comments.
	Syntax:	gambasCodeDocumentor.awk FILE.[class|module] > NEW_FILE.[class|module]
				or
				gawk -f gambasCodeDocumentor.awk FILE.[class|module] > NEW_FILE.[class|module]
	
#gambasDocumentGenerator.awk
	Script that generates documentation from the comments.
	Syntax:	gambasDocumentGenerator.awk /Source/root/path /Documentation/Target/Path
				or
				gawk -f gambasDocumentGenerator.awk /Source/root/path /Documentation/Target/Path