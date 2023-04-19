import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression

# 读取数据
data = pd.read_csv('data/game_null.csv')
#1610612744 GSW
#1610612760 Thunder

gsw = data[data['HOME_TEAM_ID'].isin([1610612744]) | data['VISITOR_TEAM_ID'].isin([1610612744])]
gsw['is_home'] = (gsw['HOME_TEAM_ID'] == 1610612744)
gsw['win'] = (gsw['HOME_TEAM_WINS'] == 1)

# 选取需要用到的特征
features = ['is_home']

# 拆分训练集和测试集
X_train, X_test, y_train, y_test = train_test_split(gsw[features], gsw['win'], test_size=0.2, random_state=42)

# 训练逻辑回归模型
model = LogisticRegression()
model.fit(X_train, y_train)

# 评估模型性能
accuracy = model.score(X_test, y_test)
print(f"模型准确率：{accuracy:.2f}")

# 输出模型系数
coefficients = dict(zip(features, model.coef_[0]))
print(f"模型系数：{coefficients}")

thu = data[data['HOME_TEAM_ID'].isin([1610612760]) | data['VISITOR_TEAM_ID'].isin([1610612760])]
thu['is_home'] = thu['HOME_TEAM_ID'] == 1610612760
thu['win'] = thu['HOME_TEAM_WINS'] == 1

X_train, X_test, y_train, y_test = train_test_split(thu[features], thu['win'], test_size=0.2, random_state=42)

model = LogisticRegression()
model.fit(X_train, y_train)

accuracy = model.score(X_test, y_test)
print(f"模型准确率：{accuracy:.2f}")

coefficients = dict(zip(features, model.coef_[0]))
print(f"模型系数：{coefficients}")