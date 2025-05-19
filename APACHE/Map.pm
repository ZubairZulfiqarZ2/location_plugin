
package Apache::Ocsinventory::Plugins::Location::Map;

use strict;

use Apache::Ocsinventory::Map;

$DATA_MAP{location} = {
    mask => 0,
    multi => 0, # Only one location per device
    auto => 1,
    delOnReplace => 1,
    sortBy => 'LATITUDE',
    writeDiff => 0,
    cache => 0,
    fields => {
        LATITUDE => {},
        LONGITUDE => {},
        ALTITUDE => {},
				PERMISSION => {},
        HORIZONTALACCURACY => {},
        VERTICALACCURACY => {},
        SPEED => {}
    }
};

1;