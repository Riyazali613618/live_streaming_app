import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LiveStreamOverlayWidget extends ConsumerWidget {
  const LiveStreamOverlayWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We use Stack to layer UI elements over the full screen video.
    return const Stack(
      children: [
        // --- 1. Top Section (Header, Live Count, Exit) ---
        _TopHeaderControls(),

        // --- 2. Side Buttons (Like, Share, More) ---
        _SideButtons(),

        // --- 3. Chat Listing (Middle-Bottom) ---
        _ChatListing(),

        // --- 4. Bottom Section (Chat Input & Action Button) ---
        _BottomControls(),
      ],
    );
  }
}

// --- 1. Top Header Controls (Live Count, Host Info, Exit) ---
class _TopHeaderControls extends StatelessWidget {
  const _TopHeaderControls();

  @override
  Widget build(BuildContext context) {
    // Determine the safe padding from the top edge (notch area)
    final topPadding = MediaQuery.of(context).padding.top + 10;

    return Positioned(
      top: topPadding,
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Left: Host Info (Username + Follow Button)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                // Avatar Placeholder
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 20, color: Colors.black),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Surbhi Tyagi', // 1. Username
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.add_circle, // Follow Plus Button
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                    Text(
                      'Digital Marketing Expert',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),

          // Top Right: Live Count and Cross Button (Exit)
          Row(
            children: [
              // Live User Count (Eye Icon) - 2. Live Users Count
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '30k', // Live User Count
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Cross Button (Exit)
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                // Action to leave call and pop screen
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- 2. Side Buttons (Like, Share, More) ---
class _SideButtons extends StatelessWidget {
  const _SideButtons();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 120, // Positioned above the chat input
      right: 16,
      child: Column(
        children: [
          // Like Button - 3. Like Button
          _buildActionButton(
            icon: Icons.thumb_up_alt_outlined,
            label: '56k',
            onTap: () {
              /* Handle Like */
            },
          ),
          const SizedBox(height: 16),
          // Share Button - 3. Share Button
          _buildActionButton(
            icon: Icons.share,
            label: '',
            onTap: () {
              /* Handle Share */
            },
          ),
          const SizedBox(height: 16),
          // More Button - 3. More Button
          _buildActionButton(
            icon: Icons.more_horiz,
            label: '',
            onTap: () {
              /* Handle More */
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Icon(icon, color: Colors.white, size: 25),
        ),
        if (label.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
        const SizedBox(height: 10),
      ],
    );
  }
}

// --- 6. Chat Message Listing ---
class _ChatListing extends StatelessWidget {
  const _ChatListing();

  // Placeholder data mimicking the screenshot
  static const List<Map<String, String>> dummyChatMessages = [
    {'name': 'Shivani Roy', 'text': 'Joined'},
    {'name': 'Shivani Roy', 'text': 'Joined'},
    {'name': 'Shivani Roy', 'text': 'Joined'},
    {'name': 'Rahul Verma', 'text': 'Joined'},
    {
      'name': 'Abhinav Tyagi',
      'text': 'Hi How are you? I want to connect with you!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80, // Positioned above the input box (50px input + 10px padding)
      left: 16,
      right: 100, // Make room for the side buttons
      child: SizedBox(
        height: 200, // Fixed height for the chat window
        child: ListView.builder(
          reverse: true, // Show newest messages at the bottom
          itemCount: dummyChatMessages.length,
          itemBuilder: (context, index) {
            final message = dummyChatMessages.reversed.toList()[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar placeholder for chat
                  const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white70,
                    child: Icon(Icons.person, size: 12, color: Colors.black),
                  ),
                  const SizedBox(width: 8),
                  // Chat Text
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${message['name']}: ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: message['text'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// --- 4. Chat Input Box and Book a Session Button ---
class _BottomControls extends StatelessWidget {
  const _BottomControls();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 16,
      right: 16,
      child: Row(
        children: [
          // Chat Message Input Box - Now vertically aligned
          Expanded(
            child: Container(
              height: 44, // Reduced height
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                // Use a slightly lighter grey color for better visual match
                color: const Color(0xFF8D8D8D),
                borderRadius: BorderRadius.circular(
                  22,
                ), // Half of height for perfect pill shape
                // border: Border.all(color: Colors.white.withOpacity(0.3)), // Border removed as per image
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                // Ensures vertical centering of icon and field
                children: [
                  // Icon alignment is now perfect
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Type your message',
                        // FIX: Remove default vertical padding to center text
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize:
                              12, // Slightly larger font for better visibility
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Book a Session Button
          SizedBox(
            height: 44,
            child: ElevatedButton.icon(
              onPressed: () {
                // Implement booking logic
              },
              icon: const Icon(Icons.call, color: Colors.white, size: 20),
              label: const Text(
                'Book a Session',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9C27B0),
                // Purple color from the screenshot
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    22,
                  ), // Half of height for perfect pill shape
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                elevation: 0, // Removed shadow for flat look
              ),
            ),
          ),
        ],
      ),
    );
  }
}
