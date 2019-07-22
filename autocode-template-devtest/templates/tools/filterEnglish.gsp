<%

    def isEnglish = { ch ->
        if (ch >= 33 && ch <= 126) {
            return true;
        }
    }

    def filterEnglish = { it ->
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < it.length(); i++) {
            char ch = it.charAt(i);
            if (isEnglish(ch)) {
                break;
            }
            sb.append(ch);
        }
        return sb.toString();
    }


    data.each { it ->
        println filterEnglish(it.trim());
    }
%>