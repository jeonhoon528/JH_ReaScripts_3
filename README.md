## 동작 방식

`JH_auto_select_tracks_of_selected_items.lua`는 REAPER에서 현재 선택된 미디어 아이템을 지속적으로 감지합니다.

- 선택된 아이템이 포함된 모든 트랙을 수집
- 이전 트랙 선택 상태와 비교
- 실제로 변경이 필요한 트랙만 선택 상태 갱신
- 필요한 경우에만 Arrange 뷰를 갱신

이를 통해 아이템 선택과 트랙 선택을 항상 동기화하면서, 불필요한 업데이트를 줄여 마키 선택 시 더 부드러운 동작을 제공합니다.

## How It Works

`JH_auto_select_tracks_of_selected_items.lua` continuously monitors the currently selected media items in REAPER.

- It collects all tracks that contain the selected items
- Compares them with the previously selected track set
- Updates only the tracks whose selection state needs to change
- Refreshes the arrange view only when necessary

This ensures that track selection always stays in sync with item selection, while minimizing unnecessary updates for better performance and smoother interaction during marquee selection.
