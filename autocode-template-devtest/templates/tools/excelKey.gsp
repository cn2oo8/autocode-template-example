<%

    data.each{
        groupInfo ->
        groupInfo.configs.each{ config ->
            def dateKey = "data.statInfo.${groupInfo.groupKey}.${config.simpleKey}"
            println "\${${dateKey}.preDataMax}\t\${${dateKey}.curDataMax}\t\${${dateKey}.maxInc}\t\${${dateKey}.preDataCount}\t\${${dateKey}.curDataCount}\t\${${dateKey}.totalInc}"
        }
    }

%>