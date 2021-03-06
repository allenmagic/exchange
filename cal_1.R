# 设置工作目录
setwd("~/Documents/R/exchange/")
library(plyr)

# 从exchange.csv读取原始数据
rm(list = ls())   # 预清楚所有对象
ex <- read.csv("exchange.csv",header = T)
colnames(ex) <- c("type","amount","date","product")  # 重新命名数据的列名称
ex <- data.frame(ex,month=as.numeric(as.character(substr(ex$date,1,6))))
ext <- ddply(ex,c("product"),summarise,ex_no = length(product),ex_a = sum(amount))


# 从register.csv读取用户注册的日期数据
r <- read.csv("register.csv",header = T)     # 读存数据
re <- data.frame(r,sd = substr(r$date,1,4))  # 构建新的数据化
re <- re[re$source!="柜台迁移",]
re$source <- droplevels(re$source)
re$sd <- as.numeric(as.character(re$sd))     # 将新的列sd转换为数字

# 保有量数据
a <- data.frame(plat=c("企业版web","客户端"),total=c(158.5,2.5))

# 绘制按照不产品上的交易情况的条形图
library(ggplot2)   # 加载ggplot2包
library(plyr)      # 加载plyr包
d <- ddply(ex,"product",summarise,t_con = length(product),t_amt = sum(amount))   # 生成d
lv <- c("企业web版","企业客户端","TA强赎","企业app") # 设定因子水平的顺序
t <- ddply(re,c("source","sd"),summarise,t_no = length(source))  # 生成t


# 一些小设置
font <- c("WenQuanYiMicroHei")   # Macbook使用文泉驿字体
#font <- c("Microsoft YaHei")   # Mac使用微软雅黑字体

# 绘制不同产品交易笔数的条形图
p <- ggplot(d,aes(x=product,y=t_con,fill=product))
p <- p + geom_bar(stat = "identity",width = 0.6)
p <- p + scale_x_discrete(limits=lv)  #改变柱状图排序按照lv水平排序
p <- p + labs(title="不同产品发生的交易量（过去一年）",x=NULL,y="交易额",fill="企业版产品")
p <- p + theme(axis.title.y = element_text(angle = 0))
p <- p + theme(plot.title = element_text(hjust = 0.6,colour = "blue"))  # 改变标题的位置和颜色
p <- p + theme(text = element_text(family = font))


# 绘制不同产品交易额大小的条形图
q <- ggplot(d,aes(x=product,y=t_amt,fill=product)) 
q <- q + geom_bar(stat = "identity",width = 0.6)
q <- q + scale_x_discrete(limits=lv)  #改变柱状图排序按照lv水平排序
q <- q + labs(title="不同产品发生的交易额（过去一年）",x=NULL,y="交易笔数",fill="企业版产品")
q <- q + theme(axis.title.y = element_text(angle = 0))
q <- q + theme(plot.title = element_text(hjust = 0.6,colour = "blue"))  # 改变标题的位置和颜色
q <- q + theme(text = element_text(family = font))

# 绘制按照月份统计的不同产品的注册用户数
s <- ggplot(t,aes(x=sd,y=t_no,fill=source))
s <- s + geom_bar(stat = "identity",position = "dodge",width = 0.5)
s <- s + labs(title="新注册用户数",x=NULL,y="新注册用户",fill="注册平台")
s <- s + theme(text = element_text(family = font))
s <- s + theme(axis.title.y = element_text(angle = 0))
s <- s + theme(plot.title = element_text(hjust = 0.5,colour = "blue"))  # 改变标题的位置和颜色

# 绘制保有量条形图
b <- ggplot(a,aes(x=plat,y=total,fill=plat))
b <- b + geom_bar(stat = "identity",width = 0.6)
b <- b + labs(title="产品保有量",x=NULL,y="保有量",fill="企业版产品")
b <- b + theme(text = element_text(family = font))
b <- b + theme(axis.title.y = element_text(angle = 0))
b <- b + theme(plot.title = element_text(hjust = 0.5,colour = "blue"))  # 改变标题的位置和颜色


# 将图放在一个显示设备里
library(grid)
png("p.png",width = 1000,height = 800)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2,2)))
vplayout <- function(x,y)
  viewport(layout.pos.row = x,layout.pos.col = y)
print(p,vp = vplayout(1,1))
print(q,vp = vplayout(1,2))
print(s,vp = vplayout(2,1))
print(b,vp = vplayout(2,2))
dev.off()


