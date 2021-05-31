<%
    String keyStart = "groupId=";
    data.each { it ->
        int idx = it.indexOf(keyStart);
        if (idx > -1) {
            int endIdx = it.indexOf(",", idx);
            println it.substring(idx + keyStart.length(), endIdx);
        }
    }

%>
