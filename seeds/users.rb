module Users
  def self.seed
    users_list = [
        { name: "Nipun Manocha", email: "nipun.manocha@1mg.com", password: "123456", password_confirmation: '123456' },
        { name: "Kartik", email: "kartik.arora@1mg.com", password: 'kartik', password_confirmation: 'kartik'},
        { name: "Himanshu", email: "himanshu@1mg.com", password: "983737", password_confirmation: '983737' },
        { name: "Viren", email: "viren@1mg.com", password: 'viren123', password_confirmation: 'viren123' }
    ]
    User.create(users_list)
  end
end
