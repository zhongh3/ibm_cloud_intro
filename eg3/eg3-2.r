

library(ibmdbR)

# @hidden_cell
# This connection object is used to access your data and contains your credentials.
# You might want to remove those credentials before you share your notebook.

con.31afad984ad94737a3d9d6d9e7e2f234 <- idaConnect("DASHDB;DATABASE=BLUDB;HOSTNAME=dashdb-entry-yp-dal09-10.services.dal.bluemix.net;PORT=50000;PROTOCOL=TCPIP;", uid = "dash100021", pwd = "w8JtWH_iGl0_", conType = "odbc")
idaInit(con.31afad984ad94737a3d9d6d9e7e2f234)

data.df.1 <- as.data.frame(ida.data.frame('DASH100021.EDSTATS'))
# To display the first few lines of the dataframe
head(data.df.1)

# You can close the connection with the following code:
# idaClose(con.31afad984ad94737a3d9d6d9e7e2f234)


library(ggplot2)
data_frame1 <- data.df.1[, c('Currency_Unit', 'Income_Group', 'Region', 'Short_Name')]

data_frame1$"Income_Group" <- factor(data_frame1$"Income_Group", 
                                     levels=c("Low income","Lower middle income","Upper middle income","High income: nonOECD","High income: OECD"), 
                                     labels=c("LI","LMI","UMI","HIN","HIO"))

data_frame1[1:10,]
counts <- table(data_frame1$"Income_Group")
counts

barplot(counts, main ="Income Distribution", xlab="Income Group")
