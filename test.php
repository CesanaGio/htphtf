//MCS2
include.once('/_software/live/_lib/_MCLib')

db.connect

$void = _htpBegin()
dbs.run("testingHTP()")
$void = _htpEnd()

db.commit

method(_htpBegin())
{
	query.run("select sys_context('userenv','sid') as ID from dual",$c)
	$sessionID = $c['ID']
	dml.run("delete from HTPTEMP where SESSIONID='$sessionID'",$cdml)
}

method(_htpEnd())
{
	query.run("select sys_context('userenv','sid') as ID from dual",$c)
	$sessionID = $c['ID']
	query.run.loop("select LINE from HTPTEMP where SESSIONID='$sessionID' order by rownum",$c)
	{
		show(htmlspecialchars_decode($c[$ic]['LINE']))
	}
	dml.run("delete from HTPTEMP where SESSIONID='$sessionID'",$cdml)
}

