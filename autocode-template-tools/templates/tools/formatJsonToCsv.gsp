<%

    data.each { key, value ->
        print "${key}\t"
        print StringUtils.join(value,",")
        println ""
    }

%>