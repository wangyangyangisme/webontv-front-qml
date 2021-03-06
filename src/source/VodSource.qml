import QtQuick 2.2

Source {
    function getResult(channelId, callback) {
        getVodPrograms(channelId, 10, function(result) {
            var categories = [];
            for(var i in result.Categories) {
                var category = result.Categories[i],
                transformedCategory = {
                    id: category.id,
                    index: i,
                    name: category.name,
                    size: category.nbPrograms,
                    programs: []
                };
                transformedCategory.programs.push({index: 0});
                for (var j in category.Programs) {
                    var program = category.Programs[j];
                    transformedCategory.programs.push({
                        id: program.id,
                        index: parseInt(j) + 1,
                        title: program.title,
                        duration: program.duration,
                        startDate: program.startDate,
                        background: config.imageServerPath + program.imageFilepath
                    });
                }
                categories.push(transformedCategory);
            }
            callback(categories);
        });
    }
}
