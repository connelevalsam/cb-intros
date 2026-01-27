## 0.2.2

- Updated `CbIntros` to accept a `List<Widget>` for the `items` parameter instead of a `List<String>`. This allows for greater flexibility, enabling the use of `Icon` widgets or any other custom widget in the onboarding screens, not just images.
- Renamed `images` parameter to `items` to better reflect the change.

## 0.2.0

Initial release of cb_intros.
Implements a customizable onboarding/intro screen widget with:
Smooth PageView transitions.
Configurable background colors, images, titles, descriptions, button color, and padding.
Animated smooth page indicator.
Unique "side-cut" design for the text area.
Integration with flutter_animate for subtle animations.
Upgraded to use widgetBuilder instead of just a widget.
