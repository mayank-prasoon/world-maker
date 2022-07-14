
# ============================================================================ #
#                              RESOURCE UTILITIES                              # 
# ============================================================================ #

# this class has resource utilities


class_name ResourceUtilies
extends Reference

#                  === SUB CLASS ===

# this sub class check if file is null
class NullCheck extends Reference:
	
	enum {
		OK,
		NULL_FILE
	}


	# check if file is null
	static func check_for_null(resource:Resource)->int:
		if !(resource == null): # file is not null
			return OK
		else:                   # file is null
			return NULL_FILE
