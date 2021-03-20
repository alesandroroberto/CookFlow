//
//  RecipeStateTemplate.swift
//  CookFlow
//
//  Created by Alexander Krupichko on 20.03.2021.
//

import Foundation

extension Array where Element == RecipeBlock {
    static let testRecipePage: [Element] = [
        .title("Суп из семи залуп"),
        .photo(URL(string: "https://cdn.lifehacker.ru/wp-content/uploads/2018/05/tomatnyj-sup_1525442518-1140x570.jpg")!),
        .text("""
Подготовьте ингридиенты:\n
- Немножечко укропу\n
- Кошачья жопа\n
- Тараканьи лапки\n
- Сикель старой бабки\n
- Один носок\n
- Пизды кусок\n
- Ведро воды\n
- Хуй
"""
        ),
        .photoGrid(
            [
                URL(string: "https://xcook.info/wp-content/uploads/sites/default/files/recipe/7/borshh-s-chesnokom-1.jpg")!,
                URL(string: "https://img.iamcook.ru/old/upl/recipes/byusers/misc/6009/4c39fe3716d1874254dff078fc7232d4-2016.jpg")!,
                URL(string: "https://img.iamcook.ru/old/upl/recipes/byusers/misc/1378/49e956b3967bd2e5b8891e37ebbeda44-2017.jpg")!,
                URL(string: "https://the-challenger.ru/wp-content/uploads/2017/08/shutterstock_631420511-800x534.jpg")!,
                URL(string: "https://kakvarim.ru/wp-content/uploads/2019/06/kak-varit-kabachok-post-800x500.jpg")!,
                URL(string: "https://1249277.ssl.1c-bitrix-cdn.ru/upload/iblock/ccd/6Tigrovyy_piton_Foto_Mikhail.jpg?1601929920385414")!,
                URL(string: "https://cs4.pikabu.ru/post_img/2014/06/24/9/1403616968_250897811.jpg")!,
                URL(string: "https://layf.info/wp-content/uploads/sites/default/files/14-foto-prikol-penis.jpg")!
            ]
        ),
        .text("""
На медленном огне варить, к ебёной мати" говорить, снимать ложкой пенку, биться головой о стенку охапка дров, и плов готов!
"""
        )
    ]
}
