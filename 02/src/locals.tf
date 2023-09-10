# ### Задание 5
# 1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} 
# с несколькими переменными по примеру из лекции.
# 2. Замените переменные с именами ВМ из файла variables.tf на созданные вами local-переменные.
# 3. Примените изменения.
locals{
    local_name_vm_db    = "netology-${var.vpc_name}-platform-db-${var.vm_web_image}"
    local_name_vm_web   = "netology-${var.vpc_name}-platform-web-${var.vm_web_image}"
}
# Не понятно какие переменные использовать для интерполяции, если, конечно, требуется создать похожее имя ВМ (netology-develop-platform-web). 
# Я добавил ${var.vpc_name} - оно равно develop, ну и добавил ${var.vm_web_image} - ubuntu-2004-lts, остальное прописал как string