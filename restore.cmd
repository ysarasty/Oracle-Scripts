ECHO ON
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
set secs=%time:~6,2%
if "%secs:~0,1%" == " " set secs=0%secs:~1,1%
set year=%date:~-4%
set month=%date:~4,2%
if "%month:~0,1%" == " " set month=0%month:~1,1%
set day=%date:~0,2%
if "%day:~0,1%" == " " set day=0%day:~1,1%

set datetimef=%year%%month%%day%_%hour%%min%%secs% 

CALL E:\tools\ora_env.cmd %1% 
ECHO ************************************************************
ECHO *			STARTING %ORACLE_SID%			*
ECHO ************************************************************

SQLPLUS /NOLOG @E:\TOOLS\Scripts\Start_BD_NOMOUNT.sql "E:\oracle\admin\%ORACLE_SID%\pfile\init%ORACLE_SID%.ORA" "%ORACLE_SID%"

ECHO ************************************************************


%ORACLE_HOME%\BIN\rman.exe  NOCATALOG cmdfile=E:\TOOLS\Scripts\res_rec.rman %ORACLE_SID% %LOG_FULL%
ECHO ************************************************************

SQLPLUS /NOLOG @E:\TOOLS\Scripts\BD_OPEN.sql "E:\oracle\admin\%ORACLE_SID%\pfile\init%ORACLE_SID%.ORA" "%ORACLE_SID%"
ECHO ************************************************************
ECHO *			Done with %ORACLE_SID%			*
ECHO ************************************************************

