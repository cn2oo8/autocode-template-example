{
<%



    def makeFieldValue= {field->
        def dataType =field.fieldClass;
        if ("String".equals(dataType) || "java.lang.String".equals(dataType)) {
            return tableNameUtil.wrapWithQuote("aa");
        }
        if ("java.util.Date".equals(dataType) || "java.sql.Timestamp".equals(dataType)) {
            return String.valueOf(System.currentTimeMillis());
        }
        if ("Float".equalsIgnoreCase(dataType) || "Double".equalsIgnoreCase(dataType) || "Integer".equalsIgnoreCase(dataType) || "Long".equalsIgnoreCase(dataType) ||
                "java.math.BigDecimal".equals(dataType)) {
            String value = "1";
            return value;
        }
        if("List".equalsIgnoreCase(dataType) || "Set".equalsIgnoreCase(dataType) || "Collection".equalsIgnoreCase(dataType) ||
                "java.util.List".equalsIgnoreCase(dataType)|| "java.util.HashSet".equalsIgnoreCase(dataType) ||
                dataType.startsWith("List<")|| dataType.startsWith("Set<")
        ){
            return "[]";
        }

        return "null";
    }




    def fieldList = data.fieldList;
    fieldList.eachWithIndex { it, index ->
        def fieldValue = makeFieldValue(it)
        print "   \"${it.dataName}\": ${fieldValue}"
        if ((index + 1) < fieldList.size()) {
            print ","
        }
        println ""
    }
%>}