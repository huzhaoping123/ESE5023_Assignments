setwd('C:/Users/ping ping/Desktop/Assignment/Assignment_03_hzp')
library(ggplot2)
library(dplyr)
library(tidyr)

#CuΪĳͭβ���0.1m��1m�����е�ͭŨ��
Cu <- read.csv('Cu.csv',header = T,encoding = "UTF-8")
colnames(Cu) <- c('0.1m','1m')

#dischargeΪsac cityˮ�Ĺ۲�վ�ı���ܺӾ������ݺ͸õصĽ���������
discharge <- read.csv('discharge.csv',header = T)

#PRCPΪrockwell city�Ľ���������
PRCP <- read.csv('ROCKWELL CITY.csv')

#���ݵ�Ԥ����
#discharge
discharge <- as_tibble(discharge)
discharge1 <- discharge %>%
  filter(year >= 2008) %>%
  select(Dischrge.ft3.s , PRCP.inch.SAC.CITY)
#PRCP
PRCP1 <- PRCP %>%
  mutate(year = as.numeric(substr(DATE,1,4))) %>%
  filter(year >= 2008) %>%
  select(PRCP) %>%
  mutate(f = "rockwell")

#3.7.1 ͭβ���0.1m��1m��Ŀ����У�ͭŨ���в����
par(mfrow=c(1,2))
hist(Cu[,1])
hist(Cu[,2])
t.test(Cu[,1] , Cu[,2])
#������Ϊ0.1m��1m���CuŨ���޲��

#3.7.2 sac city��ͬγ�ȵ�rockwell city�Ľ����в����
#�����ݽ�һ������
discharge2 <- discharge1 %>%
  select(PRCP.inch.SAC.CITY) %>%
  mutate(f = "sac")
s_r <- matrix()
s_r <- discharge2
s_r[4384:8728,] <- PRCP1[1:4345,]
colnames(s_r) <- c('PRCP','f')
s_r1 <- s_r %>%
  mutate(f = as.factor(f))
#�������
anova_one_way3_7 <- aov(PRCP ~ f,data = s_r)
summary(anova_one_way3_7)
#������Ϊ���߽�ˮ����������

#3.7.3 sac city�Ľ������뱱��ܺӾ�������֮��������Թ�ϵ��
#�������ݵ�ֱ��ͼ
par(mfrow=c(1,2))
hist(discharge1$Dischrge.ft3.s)
hist(discharge1$PRCP.inch.SAC.CITY)
#ɢ��ͼ���������
plot(Dischrge.ft3.s ~ PRCP.inch.SAC.CITY,data = discharge1)
fit3_7 <- lm(Dischrge.ft3.s ~ PRCP.inch.SAC.CITY,data = discharge1)
summary(fit3_7)
abline(fit3_7,lwd = 2, col = "red")
#���Թ�ϵ�����Ǻܺ�