<%
    Double sum = 0.0d;

    data.each { line ->
        if (line.size() < 2) {
            return;
        }
        Double task = Double.valueOf(line.get(0).trim());
        Double pct = Double.valueOf(line.get(1).trim().replace("%", ""));
        sum = sum + (task * pct) / 100d;
    }
    println """sum is : ${sum}"""
%>