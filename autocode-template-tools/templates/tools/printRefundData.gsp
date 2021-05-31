团长id,户主,银行卡号,身份证号码
<%
 data.result.data.each{
     item ->
     println """${item.original_company_id},${item.card_owner},'${item.bank_account}','${item.ext1}'"""
 }
%>
