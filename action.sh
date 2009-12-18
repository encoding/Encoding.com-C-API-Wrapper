static string HTTPPost(string sUrl, string sRequest)
{
    HttpWebRequest request = (HttpWebRequest)WebRequest.Create(sUrl);
    request.Method = "POST";
    request.ContentType = "application/x-www-form-urlencoded";
    request.ContentLength = sRequest.Length;
    request.GetRequestStream().Write(Encoding.UTF8.GetBytes(sRequest), 0, sRequest.Length);
    request.GetRequestStream().Close();
    HttpWebResponse response = (HttpWebResponse)request.GetResponse();
    StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8);
    string result = reader.ReadToEnd();
    reader.Close();
    return result;
}
 
static void Main_Encoding(string origin, string destination)
{  
    string xml, sUrl, sRequest, result, userID, userKey;

    //put your real userID and userKey below
    userID = "0";
    userKey = "your_key";
               
    xml = string.Format(
@"<?xml version=""1.0""?>
<query>
<userid>{0}</userid>
<userkey>{1}</userkey>
<action>AddMedia</action>
<source>{2}</source>
<format>
<output>flv</output>
<destination>{3}</destination>
</format>
</query>", userID, userKey, origin, destination);

    sUrl = "http://manage.encoding.com/";
    sRequest = "xml=" + HttpUtility.UrlEncode(xml);
    result = HTTPPost(sUrl, sRequest);
}

 
static void Main(string[] args)
{
    String origin = "http://yoursite.com/video/movie.avi";
    String destination = "ftp://username:password@yourftphost.com/video/encoded/test.flv";
    Main_Encoding(origin, destination);
}