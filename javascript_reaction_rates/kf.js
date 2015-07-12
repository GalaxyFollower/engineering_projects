function kf(A,B,Ea,T)
{
	var RU = 83145100;
	var kf=A*Math.pow(T, B)*Math.exp(Ea*41840000/(RU*T));
	return log10(kf);
}

function log10(val) {
  return Math.log(val) / Math.LN10;
}